def consolidate_cart(cart)
  item_count = {}
  cart.each do |item|
    item.each do |key, value|
      if item_count.has_key?(key)
        item_count[key][:count] += 1 
      else 
        item_count[key] = value.merge({:count => 1})
      end 
   end 
  end 
  item_count
end


# "AVOCADO W/COUPON"
# def apply_coupons(cart, coupons)
#   new_obj = {}
#   cart.each do |item|
#     new_obj[item.first] = item.last
#   end 
#   puts new_obj
#   coupons.each do |ele|
#     puts ele
#   {'ITEM NAME W/COUPON' => ele[:item] }
#   end 
# end

def apply_coupons(cart, coupons)
  hash = cart
  coupons.each do |coupon_hash|
    # add coupon to cart
    item = coupon_hash[:item]

    unless hash[item].nil? && hash[item][:count] =< coupon_hash[:num]
      temp = {"#{item} W/COUPON" => {
        :price => coupon_hash[:cost],
        :clearance => hash[item][:clearance],
        :count => 1
        }
      }
      
      if hash["#{item} W/COUPON"].nil?
        hash.merge!(temp)
      else
        hash["#{item} W/COUPON"][:count] += 1
        #hash["#{item} W/COUPON"][:price] += coupon_hash[:cost]
      end
      
      hash[item][:count] -= coupon_hash[:num]
    end
  end
  hash
end

def apply_clearance(cart)
  cart_obj = {}
  cart.each do |item|
    cart_obj[item.first] = item.last 
    if cart_obj[item.first][:clearance] == true 
       cart_obj[item.first][:price] = (cart_obj[item.first][:price] * 0.8).round(3) 
    end 
  end 
  cart_obj
end



def checkout(cart, coupons)
  # code here
end

# def checkout(items, coupons)
#   cart = consolidate_cart(items)
#   cart1 = apply_coupons(cart, coupons)
#   cart2 = apply_clearance(cart1)
  
#   total = 0
  
#   cart2.each do |name, price_hash|
#     total += price_hash[:price] * price_hash[:count]
#   end
  
#   total > 100 ? total * 0.9 : total
  
# end
