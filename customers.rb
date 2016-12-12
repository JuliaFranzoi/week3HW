require_relative("sql_runner")

class Customers

  attr_reader :id
  attr_accessor :name, :funds
  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i
    
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ('#{ @name }', #{ @funds }) RETURNING id;"
    customers = SqlRunner.run( sql ).first
    @id = customers['id'].to_i
  end


  def self.all()#returns one array with all the instances(costumer1, costumer2 etc...), so customer.all[0] will return the first isntance creates eg customer1
    sql = "SELECT * FROM customers;"
    return Customers.get_many(sql) 
  end


  def self.get_many( sql )#creating a new object
    customers = SqlRunner.run( sql )
    customer_objects = customers.map{ |customer| Customers.new( customer) }
    return customer_objects
  end

  def self.delete_all() 
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end
  
  def update()
    sql = "UPDATE customers SET (name, funds) = ('#{@name}', #{@funds}) WHERE id = #{@id};"
    SqlRunner.run(sql)
  end


  def delete()
    sql = "DELETE FROM costumers WHERE id = #{@id};"  
    SqlRunner.run(sql)
  end  
  
  def films()
    sql = "SELECT films.* FROM films
     INNER JOIN tickets 
     ON films.id = tickets.film_id
     WHERE tickets.customer_id = #{@id};"
    return Films.get_objects(sql).
  end
    
  def tickets()
    sql = "SELECT * FROM tickets WHERE customer_id =#{@id};"
    return Tickets.get_objects(sql)
  end 

  def how_many_tkts()
    sql = "SELECT * FROM tickets WHERE customer_id =#{@id};"
    return Tickets.get_objects(sql).count
  end  
 
  def total_price(c)
    total= []
    for o in c
      total_price.push(o.get_price())
    end
    return total.sum
  end    



  
  def total_price()
      sql = "SELECT films.price FROM films
       INNER JOIN tickets 
       ON films.id = tickets.film_id
       WHERE tickets.customer_id = #{@id};"
      film_prices = SqlRunner.run( sql )
      array_prices=[]
      film_prices.map{|price| array_prices << price.get_price()}
      return array_prices
  end
  
   


  # def update_funds()
  #    customer1.
  # end  

end