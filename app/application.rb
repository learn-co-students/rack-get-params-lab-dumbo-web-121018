class Application
  @@cart = []
  @@items = ["Apples","Carrots","Pears"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    search_term = req.params["q"]

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      current_cart = @@cart.each do |item|
        resp.write "#{item}\n"
      end
      if current_cart.size == 0
        resp.write "Your cart is empty"
      end
    elsif req.path.match(/add/)
      items = req.params["item"]
      #binding.pry
      if @@items.include?(items) == true
      #  binding.pry
        @@cart << items
        resp.write "added #{items}"
      else
        resp.write "We don't have that item"
      end

    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
