class OpenCrumb < Crumb
  def initialize
    super
    self.requires_answer = false
  end
end
