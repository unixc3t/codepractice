class Routing
  class << self
    def route(options, binding)
      options.each do |handler_data, opts|

        eval_params = if check_func(opts[:methods])
                        more_http_methods(opts, handler_data, binding)
                      else
                        one_http_method(opts, handler_data, binding)
                      end

        eval_params.flatten.each_slice(4) {|args| define_route(*args)}
      end
    end

    def one_http_method(opts, handler_data, binding)
      if check_func(opts[:path])
        method_set_more_path(opts, opts[:methods], handler_data, binding)
      else
        [opts[:methods], opts[:path], handler_data, binding]
      end
    end

    def more_http_methods(opts, handler_data, binding)
      opts[:methods].map do |meth|
        if check_func(opts[:path])
          method_set_more_path(opts, meth, handler_data, binding)
        else
          [meth, opts[:path], handler_data, binding]
        end
      end
    end

    def method_set_more_path(opts, meth, handler_data, binding)
      opts[:path].map do |path|
        [meth, path, handler_data, binding]
      end
    end


    def run(handler_data, request, response, params)
      handler_split_data = handler_data.split('#')
      class_prefix = handler_split_data[0].capitalize
      controller_class = Object.const_get("#{class_prefix}Controller")
      controller_class.new(request, response,
                           params,
                           handler_split_data[0],
                           handler_split_data[1]).send(handler_split_data[1])
    end

    private


    def check_func(arg)
      (arg.respond_to? :map) && arg.size > 1
    end

    def define_route(method, path, handler_data, binding)
      eval(eval_string(method, path, handler_data), binding)
    end

    def eval_string(method, path, handler_data)
      "#{method}('#{path}') { Routing.run('#{handler_data}', request, response, params)}"
    end
  end
end
