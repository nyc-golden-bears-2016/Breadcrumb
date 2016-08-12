class LockedCrumb < Crumb
  def initialize
    super
    self.requires_answer = true
  end
end
