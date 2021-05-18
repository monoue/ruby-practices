def init_arg_opts(opt)
  arg_opts = {}
  opt.on('-m [month]') { |v| arg_opts[:month] = v }
  opt.on('-y [year]') { |v| arg_opts[:year] = v }
  arg_opts
end
