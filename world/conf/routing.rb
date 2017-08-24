class Routing
  class << self
    def route(options, server)
      options.each do |path, handler_data|
        path = "/#{path == :root ? '' : path}"
        handler_split_data = handler_data.split('#')
        class_prefix = handler_split_data[0].capitalize
        controller_class = Object.const_get("#{class_prefix}Controller")

        server.mount_proc path do |req, res|
          res.body = controller_class.new(req, res).send(handler_split_data[1])
        end
      end
    end
  end
end
