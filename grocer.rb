require 'pry'

def consolidate_cart(cart)
  # code here
  new_cart = {}
  cart.each do |item|
    item.each do |name, specs|
      if new_cart[name]
        new_cart[name][:count] += 1
      else
        new_cart[name] = {
          price: specs[:price],
          clearance: specs[:clearance],
          count: 1
        }
      end
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && coupon[:num] <= cart[name][:count]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += coupon[:num]
        cart[name][:count] -= coupon[:num]
      else
        cart["#{name} W/COUPON"] = {
          price: coupon[:cost]/coupon[:num],
          clearance: cart[name][:clearance],
          count: coupon[:num]
        }
        cart[name][:count] -= coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |name, specs|
    if specs[:clearance]
      specs[:price] = specs[:price] - (specs[:price] * 0.2).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0

  cart.each do |name, specs|
    total += (specs[:price] * specs[:count])
  end

  if total > 100
    total = total - (total * 0.1).round(2)
  end
  total
end
