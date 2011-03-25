class Array
    def insert(index, value, start=[], ident=0)
        (index > 0) ?
            self.insert(index - 1, value, start.concat([self[ident]]), ident + 1) :
            start.concat([value]).concat(self[ident..self.length]);
    end
end

# It may seem superfluous to wrap a class around this one function, but i plan to extend upon this framework in the future. 
# This one function, RubyStock::getStocks(<list of symbols,,,>) will return a hash with a key for each symbol passed. 
# Each hash key will then have a value which is another hash that has 2 keys of it's own, "Name" and "Price". 
# "Name" is the full name of the company with the given symbol, and "Price" is the symbols last trade value.
#
# http://www.hprog.org/fhp/RubyExamples

class RubyStock
    def RubyStock::getStocks(*symbols)
        Hash[*(symbols.collect{|symbol|[symbol,Hash[\
        *(Net::HTTP.get('quote.yahoo.com','/d?f=nl1&s='+symbol).chop\
        .split(',').unshift("Name").insert(2,"Price"))]];}.flatten)];
    end
end