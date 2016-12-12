require_relative("sql_runner")

class Films
  attr_reader :id
  attr_accessor :title, :price
  

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end 

  def save()#inserts data into the table and returns the id
    sql = "INSERT INTO films (title, price) VALUES ('#{@title}', #{price}) RETURNING id;"
    films = SqlRunner.run( sql ).first
    @id = films['id'].to_i
  end


  def self.all()#creating objects for the class films
    sql = "SELECT * FROM films;"
    return Films.get_objects(sql)
  end  
    

  def self.get_objects(sql)
    films = SqlRunner.run( sql )
    film_objects = films.map{|film| Films.new(film)}
    return film_objects
  end  

  def self.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end  
  

  def update()
    sql = "UPDATE films SET (title, price) = ('#{@title}', #{@price}) WHERE id = #{@id};"
    SqlRunner.run(sql)
  end


  def delete()
    sql = "DELETE FROM films WHERE id = #{@id};"  
    SqlRunner.run(sql)
  end 
  
  def customers()
    sql = "SELECT customers.name FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    
    WHERE film_id = #{@id};"
    return Customers.get_many(sql)
  end   

  def tickets()
    sql = "SELECT * FROM tickets WHERE film_id = #{@id}"
    return Tickets.get_objects(sql)
  end  
  
  def how_many_customers()
    sql = "SELECT * FROM tickets WHERE film_id = #{@id}"
    return Tickets.get_objects(sql).count
  end
  
  def get_price()
    return @price
  end 
end