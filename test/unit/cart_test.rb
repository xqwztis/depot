require 'test_helper'

class CartTest < ActiveSupport::TestCase
  fixtures :products

  test "cart with unique products" do
    book1 = products(:one)
    book2 = products(:ruby)
    cart = Cart.create
    cart.add_product(book1.id)
    assert cart.save!
    cart.add_product(book2.id)
    assert cart.save!
    assert_equal 2, cart.line_items.size
    assert_equal book1.price + book2.price, cart.total_price
  end
  
  test "cart with duplicate products" do
    book = products(:one)
    cart = Cart.create
    cart.add_product(book.id).save!
    cart.add_product(book.id).save!
    assert_equal 1, cart.line_items.size
    assert_equal 2, cart.line_items[0].quantity
    assert_equal 2*book.price, cart.total_price
  end
end