class PubSub
  attr_reader :lockbox_to_hotreads_queue

  def initialize(connection)
    connection.start
    channel = connection.create_channel
    @lockbox_to_hotreads_queue = channel.queue("ds.lockbox.to.hotreads")
  end

  def publish_to_queue(link)
    puts "Publishing link: #{link}"

    lockbox_to_hotreads_queue.publish(link.to_json)
  end


end
