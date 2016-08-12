class OrderedTrail < Trail
  def initialize
    super
    self.sequential = true
  end
end
