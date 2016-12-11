require('pg')
require( 'pry' )

class SqlRunner

  def self.run( sql )
    begin
      db = PG.connect({ dbname: 'cinema', host: 'localhost' })
      result = db.exec( sql )
    ensure
      db.close
    end
# binding.pry()
    return result
  end

end