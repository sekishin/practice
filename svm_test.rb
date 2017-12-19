require 'libsvm'
require 'gnuplot'
require 'pry'

class Point
  attr_reader :x, :y, :label
  
  def initialize(x,y)
    @x, @y = x, y
    @label = calc_label(x,y)
  end
  
  def calc_label(x,y)
    fx = x + 50 * Math.sin(x/15.0)
    (y > fx) ? 1 : 2
  end
end

points = Array.new(500){Point.new(rand(300), rand(300))}

Gnuplot.open do |gp|
  Gnuplot::Plot.new(gp) do |plot|
    plot.title("points")
    plot.size("ratio 1 1")
    plot.xlabel("x")
    plot.ylabel("y")
    plot.xrange("[0:300]")
    plot.yrange("[0:300]")

    p1, p2 = points.partition{|p| p.label == 1 }

    plot.data << Gnuplot::DataSet.new([p1.collect(&:x), p1.collect(&:y)])
    plot.data << Gnuplot::DataSet.new([p2.collect(&:x), p2.collect(&:y)])
    plot.data << Gnuplot::DataSet.new("x + 50 * sin(x/15.0)") do |d|
      d.with = "line"
      d.notitle
    end
  end
end
