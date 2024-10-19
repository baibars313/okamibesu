
# OkamiBesu 🐺 - Clique POA Besu Network

This repository contains the configuration to set up a private Ethereum network using Hyperledger Besu with Clique Proof of Authority (POA) consensus. Follow the steps below to clone, configure, start, and manage your Besu network nodes.

## Prerequisites

Make sure the following are installed on your machine:

- [Git](https://git-scm.com/)

## Setup Instructions 🛠️

1. **Clone the repository**  
   First, clone this repository and navigate into the project directory:
   ```bash
   git clone https://github.com/baibars313/okamibesu.git
   cd okamibesu
   ```

2. **Give execute permissions to the shell scripts**  
   Before running the setup, make the shell scripts executable:
   ```bash
   chmod +x *.sh
   ```

3. **Run the setup script**  
   This script will configure the network:
   ```bash
   ./setup.sh
   ```

## Starting the Network 🚀

Once the setup is complete, you can start individual nodes in the network as follows:

1. **Start the first node**  
   To start the first node, run:
   ```bash
   ./start_node.sh node1
   ```

2. **Start the second node**  
   For the second node, replace `<your ip>` with your machine's IP address and use the appropriate public key:
   ```bash
   ./start_node.sh node2 enode://<public_key>@<your_ip>:8545
   ```

3. **Start the third node**  
   Similarly, start the third node by providing the public key and IP:
   ```bash
   ./start_node.sh node3 enode://<public_key>@<your_ip>:8545
   ```

## Stopping the Nodes 🛑

To stop all the nodes, run the following command:
```bash
./killnodes.sh
```

You can also verify whether the nodes are still running by using:
```bash
ps -ef | grep besu
```

## Checking Logs 📄

Logs for each node are stored in respective log files. You can check them as follows:

- Node 1 logs: `node1.logs`
- Node 2 logs: `node2.logs`
- Node 3 logs: `node3.logs`

## Customizing the Network ⚙️

- **Genesis file**: You can modify the `genesis.json` file to change network parameters. For example, you can update the `alloc` section to configure initial account balances (faucet addresses).
  
- **Node Count**: To check how many nodes are currently in the network or to verify peer connections, use the following `curl` command:

```bash
curl -X POST --data '{"jsonrpc":"2.0","method":"clique_getSigners","params":["latest"],"id":1}' http://<your_ip>:8545
```

> 📌 **Note**: Replace `<your_ip>` with the actual IP address of your node.

---
## Rsetting Chain
```bash
# remove okami folder using command use sudo if you need superuser to remove folder 
sudo rm -rf okami 
# or 
rm -rf okami

```
## Contributing 🖊️

Feel free to fork the repository and submit pull requests. Contributions to improve the configuration or add new features to the Besu network setup are welcome!

## License 📄

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
```

### Key Changes:
- Clarified step-by-step instructions for setup, starting, stopping nodes.
- Included `curl` command to check the signers in the Clique network.
- Added log details and customization options for the genesis file.