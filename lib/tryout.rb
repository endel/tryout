#
#  Allows you to do dirty stuff without messing up your code base.
#
class Tryout
  # Initialize the Tryout instance.
  #
  # @example
  #   value = Tryout.try { RestClient.get('http://www.google.com') }.retry(3, :if => :empty?)
  #
  # @param [block] block content retrieval logic
  # @return [Tryout] tryout object
  def self.try &block
    self.new(&block)
  end

  autoload :VERSION, 'tryout/version'

  # Initializes Tryout with the content retrieval logic.
  # @param [block] block content retrieval logic
  def initialize(&block)
    @attempts = 0
    @block = block
  end

  # Retry the block call
  #
  # @param [Integer] times (default: 2)
  # @param [Hash] conditions
  # @option [Symbol] if       method to call from result
  # @option [Symbol] unless   method to call from result
  #
  # @return [Object] result from block call
  def retry(times = 2, conditions = {}, &evaluator)
    result = @block.call

    # Call block to evaluate valid result
    if block_given?
      conditions = { :match => evaluator.call(result) }
    end

    # Throw a exception to be rescued, if retry count reached the limit.
    if apply_conditions?(result, conditions)
      throw Exception.new("#{result.inspect} doesn't match conditions. Already retried #{times.inspect} times.")
    end

    result
  rescue Exception => e
    @attempts += 1
    if @attempts < times
      retry
    else
      raise e
    end
  end

  protected

    # Apply conditions to check a valid result
    # @param [Object] result
    # @param [Hash] conditions
    # @return [Boolean] need a retry?
    def apply_conditions?(result, conditions={})
      negation = conditions.has_key?(:unless)
      bool = if conditions.has_key?(:match)
               conditions[:match]
             elsif (method = conditions[:if] || conditions[:unless])
               result.send(method)
             end

      (negation) ? !bool : bool
    end
end

