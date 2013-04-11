# -*- coding: utf-8 -*-
require 'moretext'
require 'faker'
require 'json'

class DemoAppGenerator < Generator

  def random_title
    return random_chinese(1,10)
  end

  def random_description
    if Random.rand(2) == 1
      return random_chinese(80,100)
    else
      return random_english(200,300)
    end
  end

  def random_images
    string = ''
    for i in 1..(Random.rand(8)+1)
      string =  random_image + "," + string
    end
    
    return string.chomp(",")
  end

end
