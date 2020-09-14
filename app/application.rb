require 'pry'
require_relative '../app/application'
class Application
    @@items = Item.all
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)
        if req.path.match (/items/)
            item = req.path.split("/items/").last
            if final_item = Item.all.find{|instance| instance.name == item} 
                resp.write final_item.price
# binding.pry
            else
                resp.status = 400
                resp.write "Item not found"
            end
        else
            resp.status = 404
            resp.write "Route not found"
        end
        resp.finish
    end
end




# if req.path.match(/items/)
#     item = req.path.split("/items/").last
#     if Item.all include? item
#         resp.write Item.item.price
#     else   
#     end
# else 
#     resp.status = 404
# end
# resp.finish