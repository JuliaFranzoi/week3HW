require_relative("sql_runner")

class Tickets
  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def self.all()#getting and returning all the objects
      sql = "SELECT * FROM tickets"
      return Tickets.get_objects(sql) 
    end
   

  def save()#saving into sql table
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES (#{@customer_id}, #{film_id}) RETURNING id;"
    ticket = SqlRunner.run( sql ).first#i don't remember why is the first one
    @id = ticket['id'].to_i# i don't remember why is only id that is returned
  end

  def self.get_objects(sql)
    tickets = SqlRunner.run( sql )
    ticket_objects = tickets.map {|ticket| Tickets.new(ticket)}
    return ticket_objects
  end 

  def self.delete_all()
    sql = "DELETE FROM tickets;"
    SqlRunner.run(sql)
  end  
  
  def update()
    sql = "UPDATE tickets SET (customer_id, film_id ) = (#{@customer_id}, #{@film_id}) WHERE id = #{@id};"
    SqlRunner.run(sql)
  end


  def delete()
    sql = "DELETE FROM tickets WHERE id = #{@id};"  
    SqlRunner.run(sql)
  end  

  def customer()
    sql = "SELECT * FROM customers WHERE id = #{@customer_id};"
    customer = SqlRunner.run(sql)[0]#don't understand why
    return Customers.new(customer)
  end  
  
  def film()
    sql = "SELECT * FROM films WHERE id = #{@film_id};"
    film= SqlRunner.run(sql)[0]#don't understand why
    return Films.new(film)
   
  end


end   