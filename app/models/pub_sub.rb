class PubSub
  attr_reader :lockbox_to_hotreads_queue, :hotreads_to_lockbox_queue, :hotreads_to_lockbox_queue_top

  def initialize(connection)
    connection.start
    channel = connection.create_channel
    @lockbox_to_hotreads_queue = channel.queue("ds.lockbox.to.hotreads")
    @hotreads_to_lockbox_queue = channel.queue("ds.hotreads.to.lockbox")
    @hotreads_to_lockbox_queue_top = channel.queue("ds.hotreads.to.lockbox.top")
  end

  def publish_to_queue(link)
    puts "Publishing link: #{link}"

    lockbox_to_hotreads_queue.publish(link.to_json)
  end

  def subscribe_to_queue
    puts "Subscribing to queue"

    hotreads_to_lockbox_queue.subscribe do |delivery_info, metadata, payload|
      parsed = JSON.parse(payload)
      puts "Received Top Ten Link: #{parsed}"
      
      Link.where(url: parsed["url"]).update_all(top_ten: true)
    end

    sleep 5
  end

  def subscribe_to_queue_top
    puts "Subscribing to queue top"

    hotreads_to_lockbox_queue_top.subscribe do |delivery_info, metadata, payload|
      parsed = JSON.parse(payload)
      puts "Received Top Link: #{parsed}"

      Link.where(url: parsed["url"]).update(top_link: true)
    end

    sleep 5
  end

end
