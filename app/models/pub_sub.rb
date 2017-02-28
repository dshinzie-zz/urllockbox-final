class PubSub
  attr_reader :lockbox_to_hotreads_queue, :hotreads_to_lockbox_queue, :hotreads_to_lockbox_queue_top

  def initialize(connection)
    connection.start
    channel = connection.create_channel
    @lockbox_to_hotreads_queue = channel.queue("ds.lockbox.to.hotreads")
    @hotreads_to_lockbox_queue = channel.queue("ds.hotreads.to.lockbox")

  end

  def publish_to_queue(link)
    puts "Publishing link: #{link}"

    lockbox_to_hotreads_queue.publish(link.to_json)
  end


end
