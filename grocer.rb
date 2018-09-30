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

def apply_coupons(cart, coupon)
  coupon.each do |item|
    name = item[:item]
    if cart.has_key?(name) == true && cart[name][:count] >= item[:num]
      cart[name][:count] = cart[name][:count] - item[:num]
      new_item = name + (" W/COUPON")
      # puts cart.has_key?(new_item)
      if cart.has_key?(new_item) == false
        cart[new_item] = {:price => item[:cost], :clearance => cart[name][:clearance], :count => 1}
      else 
        cart[new_item][:count] += 1
      end
    end
  end
  cart
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



# def checkout(cart, coupons)
#   # code here
# end

def checkout(cart, coupons)
  check = consolidate_cart(cart)
  cart1 = apply_coupons(check, coupons)
  cart2 = apply_clearance(cart1)
  
  sum = 0
  
  cart2.each do |name, price|
    sum += price[:price] * price[:count]
  end
  
  sum > 100 ? sum * 0.9 : sum
  
end
