require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  test "product must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end
  
  test "product price must be above 0.01" do
    product = Product.new(title:    "My Book Title",
                          description: "yyy",
                          image_url:  "zzz.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
      product.errors[:price].join("; ")
    
    
    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
      product.errors[:price].join("; ")
      
    product.price = 1
    assert product.valid?
  end
  
  def new_product(image_url)
    product = Product.new(title: "Test title",
                          description: "yyy",
                          price:        1,
                          image_url:  image_url)
  end
  
  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/z/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    
    ok.each do |name|
      assert new_product(name).valid?, "#{name} should be valid"
    end
    
    bad.each do |name|
      assert new_product(name).invalid?, "#{name} should NOT be valid"
    end
  end
  
  test "product title should be unique" do
    product = Product.new(title: products(:ruby).title,
                          description: "zzzzz",
                          image_url:   "ruby.png",
                          price:        9.90)
    assert !product.save
    assert_equal "has already been taken",
      product.errors[:title].join("; ")    
  end
  
  test "product title must be atleast 10 length" do
    product = Product.new(title: "title",
                          description: "test description",
                          image_url:    "ruby.png",
                          price: 10)
    assert product.invalid?

    
    product.title = "test title"
    assert product.valid?
  end
end











