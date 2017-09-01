require 'mysql2'
require 'erb'
require 'yaml'
require 'csv'
require 'active_support/all'
require 'require_all'
require_relative './application'
require_relative './routing'


skip_dir_names = %w(. ..)
app_path = File.expand_path('../../app', __FILE__)
db_path = File.expand_path('../../db', __FILE__)

require_all "#{app_path}/models"
require_all "#{app_path}/controllers"
require_all db_path


=begin
#load_path = %W(#{app_path}/controllers #{app_path}/models #{db_path})

load_path.each do |path|

  loadarry = []
  Dir.foreach(path) do |file_name|
    next if skip_dir_names.include?(file_name)
    loadarry << file_name
  end

  unless loadarry.size.zero?
    # 得到文件数组父类在子类后面,先加载的子类找找不到父类，所以报错，这里暂时排序一下，先加载父类
    loadarry.sort! { |x, y| x[0] <=> y[0] }
    require File.join(path, loadarry[0])
    loadarry.delete_at(0)
  end


  loadarry.each do |file_name_rb|
    require File.join(path, file_name_rb)
  end
end
=end


