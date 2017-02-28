class PubSub
  attr_reader :lockbox_to_hotreads_queue, :hotreads_to_lockbox_queue

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

  def subscribe_to_queue
    puts "Subscribing from queue"
    require "pry"; binding.pry
    hotreads_to_lockbox_queue.subscribe do |delivery_info, metadata, payload|
      parsed = JSON.parse(payload)
      puts "Received Link: #{parsed}"

      Link.where(url: parsed["url"]).update_all(top_link: true)
    end

    sleep 2
  end

end
