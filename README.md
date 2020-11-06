# Usage

* Setup zenoh router

```
docker pull eclipse/zenoh:latest
```

* Build zenoh docker image

```
docker image build -t zenoh-dds .
```

* Run
  - Run zenoh router
```
docker run --rm --init -p 7447:7447/tcp -p 7447:7447/udp -p 8000:8000/tcp eclipse/zenoh:latest
```
  - Run zenoh-plugin-dds on the server
```
docker run --rm -it zenoh-dds bash
# After enter docker, use tmux
# 1st terminal: Run zenoh
source $HOME/.cargo/env
cargo run -- --scope /demo/dds -e tcp/127.0.0.1:7447
# 2nd terminal: Run ROS
source /opt/ros/foxy/local_setup.bash
ros2 run demo_nodes_cpp talker
```
  - Run another zenoh-plugin-dds on other server
```
docker run --rm -it zenoh-dds bash
# After enter docker, use tmux
# 1st terminal: Run zenoh
source $HOME/.cargo/env
cargo run -- --scope /demo/dds -e tcp/127.0.0.1:7447
# 2nd terminal: Run ROS
source /opt/ros/foxy/local_setup.bash
ros2 run demo_nodes_cpp listener
```
