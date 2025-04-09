*MQTT PROTOCOL:*  (Message Queuing Telemetry Transport)
--> This is lightweight message protocol designed for low bandwidth, high latency or unreliable networks
-->MQTT was invented and developed by IBM in the late 1990's. it is a messaging protocol that supports asynchronous communication between parties.an asynchronous messaging protocol de-couples the message sender and receiver in both space and time, and hence is scalable in unreliable network environments.
--> It follows a client-server model using the publish-subscribe(Pub-Sub) architecture. Unlike traditional request-response communication(like HTTP), MQTT operates as an event-driven system with 3 main steps

  1) Connection Establishment:
      ->A client(pub/sub) connects to a broker using TCP connection
      ->The client sends CONNECT packet with details like:
        Client ID(unique identification)
        Username & password(if authentication is reqd)
        Keep-alive time
        LWT(will message)
      ->Broker responds with CONNACK(connection acknowledgement) to confirm the connection
   
  2)Mesaage Publishing & Subscription:
      ->Publisher sends PUBLISH packet to broker with:
        Topic (eg; home/livingroom/temperature)
        Message payload(eg; temp: 25`C)
        QoS level (0,1 or 2)
        Retain flag(if the message should be stored)
      ->Subscribers that have already subscribed to the topic receive the message from the broker

  3)Message Delivery & Acknowledgement:
      ->if QoS 0: No acknowledement, fire and forget
      ->if QoS 1: broker sends PUBACK packet after receiving the message. if not received, the publisher resends it
      ->if QoS 2: broker and publisher exchange multiple packets (PUBLISH, PUBREC, PUBREL, PUBCOMP) to ensure exactly one message deliver


*KEY COMPONENTS:*
BROKER: 
 ->acts as a server that handles message transmission between devices
 ->manages topics and ensures reliable message delivery
 ->popular brokers:
   Mosquitto(Eclipse Mosquitto)
   Hive MQ
   EMQX

PUBLISHER:
 ->a client that sends message on the topic to a broker
 ->messages are not sent directly to specific receivers but publisheed to a topic

SUBSCRIBER:
 ->a client that receivesmessages by subscribing to a topic 
 ->any message published to that topic is delivered to all subscribers

*OTHER COMPONENTS:*
CLIENT: any device or application that connects to the broker, it can be a publisher, a subscriber or both.
SESSION: tracks the state of communication between a client and the broker, this helps with the persistent connections and ensures messages are not lost when client disconnects/reconnects.
TOPICS: MQTT messages are categorized under topics(like channels), clients subscribe to specific topics to receive relevant messages.
MESSAGE PAYLOAD: the actual content of the message(can be text, JSON, binary, etc..)
LAST WILL & TESTAMENT(LWT): a message set by a client that gets published if it unexpectedly disconnects, used to notify other clients about a failure. 
RETAINED MESSAGES: the broker stores the last message sent on a topic so new subscriber immediately receives the latest update when they subscribe.

