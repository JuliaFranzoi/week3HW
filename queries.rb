require_relative( 'customers' )
require_relative( 'Films' )
require_relative( 'tickets' )

require( 'pry' )

Tickets.delete_all()
Films.delete_all()
Customers.delete_all()



customer1 = Customers.new({ 'name' => 'Samwise Gamgee', 'funds' =>10 })
customer1.save()

customer2 = Customers.new({ 'name' => 'julia', 'funds' =>60 })

customer2.save()

film1 = Films.new({'title' => 'The Terminal', 'price' => 10})
film1.save()

film2 = Films.new({'title' => 'pretty woman', 'price' => 10})
film2.save()

ticket1  = Tickets.new({'customer_id'=> customer1.id, 'film_id' => film1.id})
ticket2  = Tickets.new({'customer_id'=> customer1.id, 'film_id' => film2.id})
ticket3  = Tickets.new({'customer_id'=> customer1.id, 'film_id' => film2.id})

ticket1.save()
ticket2.save()
ticket3.save()

binding.pry
nil