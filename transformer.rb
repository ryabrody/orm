module Transformer
  def tableize(class_name)
    pluralize(class_name.split('')).map.with_index do |letter, index|
      if is_upcase?(letter) && index == 0
        letter.downcase
      elsif is_upcase?(letter)
        "_#{letter.downcase}"
      else
        letter
      end
    end.join('')
  end

  private

  def pluralize(class_name)
    if class_name[-1] == 'e'
      class_name.push('s')
    elsif class_name[-2..-1] != %w(e s)
      class_name.push('e')
      class_name.push('s')
    end
  end

  def is_upcase?(letter)
    ('A'..'Z').cover? letter
  end
end
