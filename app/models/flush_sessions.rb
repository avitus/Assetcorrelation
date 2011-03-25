class CGI::Session::ActiveRecordStore::Session
  def self.flush_sessions
     self.delete_all "DATE_SUB(NOW(),INTERVAL 6 HOUR) > updated_at"
  end
end
