class Publisher
  Publisher
  attr_reader :lockbox_to_hotreads_queue

  def initialize(connection)
    # connection = Bunny.new({:host => "experiments.turing.io", :port => "5672", :user => "student", :pass => "PLDa{g7t4Fy@47H"})
    # connection = Bunny.new(ENV["publisher"])
    create_channel(connection)
  end

  def create_channel(connection)
    connection.start
    channel = connection.create_channel
    @lockbox_to_hotreads_queue = channel.queue("ds.lockbox.to.hotreads")
  end

  def publish_to_queue(link)
    puts "Publishing link: #{link}"
    lockbox_to_hotreads_queue.publish(link.to_json)
  end
end
