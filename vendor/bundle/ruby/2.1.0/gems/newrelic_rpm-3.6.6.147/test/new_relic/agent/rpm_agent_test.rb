# encoding: utf-8
# This file is distributed under New Relic's license terms.
# See https://github.com/newrelic/rpm/blob/master/LICENSE for complete details.

require File.expand_path('../../../test_helper', __FILE__)

class NewRelic::Agent::RpmAgentTest < Test::Unit::TestCase
  def setup
    NewRelic::Agent.manual_start
    @agent = NewRelic::Agent.instance
    @agent.stubs(:start_worker_thread)
  end

  def teardown
    NewRelic::Agent.instance.shutdown
  end

  def test_agent_setup
    assert(NewRelic::Agent.instance.class == NewRelic::Agent::Agent)
    assert_raise(RuntimeError) do
      NewRelic::Control.instance.init_plugin(:agent_enabled => false)
    end
  end

  def test_public_apis
    assert_raise(RuntimeError) do
      NewRelic::Agent.set_sql_obfuscator(:unknown) { |sql| puts sql }
    end

    ignore_called = false
    NewRelic::Agent.ignore_error_filter do |e|
      ignore_called = true
      nil
    end
    NewRelic::Agent.notice_error(StandardError.new("message"), :request_params => {:x => "y"})
    assert(ignore_called)
  end

  def test_startup_shutdown
    with_config(:agent_enabled => true) do
      @agent = NewRelic::Agent::ShimAgent.instance
      @agent.shutdown
      assert (not @agent.started?)
      @agent.start
      assert !@agent.started?
      # this installs the real agent:
      NewRelic::Agent.manual_start
      @agent = NewRelic::Agent.instance
      assert @agent != NewRelic::Agent::ShimAgent.instance
      assert @agent.started?
      @agent.shutdown
      assert !@agent.started?
      @agent.start
      assert @agent.started?
      NewRelic::Agent.shutdown
    end
  end

  def test_manual_start
    NewRelic::Agent.instance.expects(:connect).once
    NewRelic::Agent.instance.expects(:start_worker_thread).once
    NewRelic::Agent.instance.instance_variable_set '@started', nil
    NewRelic::Agent.manual_start :monitor_mode => true, :license_key => ('x' * 40)
    NewRelic::Agent.shutdown
  end

  def test_post_fork_handler
    NewRelic::Agent.manual_start :monitor_mode => true, :license_key => ('x' * 40)
    NewRelic::Agent.after_fork
    NewRelic::Agent.after_fork
    NewRelic::Agent.shutdown
  end

  def test_manual_overrides
    NewRelic::Agent.manual_start :app_name => "testjobs", :dispatcher_instance_id => "mailer"
    assert_equal "testjobs", NewRelic::Agent.config.app_names[0]
    assert_equal "mailer", NewRelic::Control.instance.local_env.dispatcher_instance_id
    NewRelic::Agent.shutdown
  end

  def test_agent_restart
    NewRelic::Agent.manual_start :app_name => "noapp", :dispatcher_instance_id => ""
    NewRelic::Agent.manual_start :app_name => "testjobs", :dispatcher_instance_id => "mailer"
    assert_equal "testjobs", NewRelic::Agent.config.app_names[0]
    assert_equal "mailer", NewRelic::Control.instance.local_env.dispatcher_instance_id
    NewRelic::Agent.shutdown
  end

  def test_set_record_sql
    @agent.set_record_sql(false)
    assert !NewRelic::Agent.is_sql_recorded?
    NewRelic::Agent.disable_sql_recording do
      assert_equal false, NewRelic::Agent.is_sql_recorded?
      NewRelic::Agent.disable_sql_recording do
        assert_equal false, NewRelic::Agent.is_sql_recorded?
      end
      assert_equal false, NewRelic::Agent.is_sql_recorded?
    end
    assert !NewRelic::Agent.is_sql_recorded?
    @agent.set_record_sql(nil)
  end

  def test_agent_version_string
    assert_match /\d\.\d+\.\d+/, NewRelic::VERSION::STRING
  end

  def test_record_transaction_should_reject_empty_arguments
    assert_raises RuntimeError do
      NewRelic::Agent.record_transaction 0.5
    end
  end

  def test_record_transaction
    NewRelic::Agent.record_transaction 0.5, 'uri' => "/users/create?foo=bar"
  end
end