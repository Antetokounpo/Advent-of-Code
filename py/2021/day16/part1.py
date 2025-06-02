from AOC import read_input

inp = read_input()

bin_string = bin(int(inp, 16))[2:]

def parse_packet(packet):
    packet_version = packet[:3]
    packet_type_id = packet[3:6]
    



