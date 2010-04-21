require File.dirname(__FILE__) + "/../spec_helper"

describe "The String class" do
  it "is a direct subclass of NSMutableString" do
    String.class.should == Class
    String.superclass.should == NSMutableString
  end

  it "can be subclassed and later instantiated" do
    k = Class.new(String)
    a = k.new
    a.class.should == k
    a << 'foo'
    a.should == 'foo'
  end
end

describe "The NSString class" do
  it "can be subclassed and later instantiated" do
    k = Class.new(NSString)
    a = k.new
    a.class.should == k
    a.size.should == 0
    # TODO
    #lambda { a << 'foo' }.should raise_error(RuntimeError)
  end
end

describe "A String object" do
  it "is an instance of the String/NSMutableString class" do
    ''.class.should == String
    ''.kind_of?(String).should == true
    ''.instance_of?(String).should == true
  end

  it "is mutable" do
    a = ''
    a << 'foo'
    a.should == 'foo'
  end

  it "can have a singleton class" do
    a = ''
    def a.foo; 42; end
    a.foo.should == 42
    a << 'foo'
    a.should == 'foo'
  end

  it "can have a singleton class with an attr_accessor" do
    a = ''
    class << a
      attr_accessor :foo
    end
    a.foo = 42
    a.foo.should == 42
  end

  it "can match() a Regex" do
    a = 'aaba'
    a.should match(/a+b./)
  end
end

describe "An NSString object" do
  it "is an instance of the NSString class" do
    a = NSString.string
    a.class.should == NSString
  end

  it "is immutable" do
    a = NSString.string
    a.size.should == 0
    lambda { a << 'foo' }.should raise_error(RuntimeError)
  end

  it "can have a singleton class" do
    a = NSString.string
    def a.foo; 42; end
    a.foo.should == 42
    # TODO
    #lambda { a << 'foo' }.should raise_error(RuntimeError)
  end

  it "forwards the block when calling a ruby method" do
    NSString.stringWithString("ybuRcaM").sub(/.+/) { |s| s.reverse }.should == "MacRuby"
  end
end
