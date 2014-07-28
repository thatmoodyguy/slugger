Dir.glob(File.expand_path('../', __FILE__) + '/lib/*', &method(:require))

Slugger.new.run
