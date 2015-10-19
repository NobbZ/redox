use common::context::context_switch;
use common::resource::URL;
use common::string::{String, ToString};
use common::vec::Vec;

use network::arp::*;
use network::common::*;

use programs::session::SessionItem;

pub struct ARPScheme;

impl SessionItem for ARPScheme {
    fn scheme(&self) -> String {
        "arp".to_string()
    }
}

impl ARPScheme {
    pub fn reply_loop() {
        while let Some(mut link) = URL::from_str("ethernet:///806").open() {
            let mut bytes: Vec<u8> = Vec::new();
            match link.read_to_end(&mut bytes) {
                Some(_) => {
                    if let Some(packet) = ARP::from_bytes(bytes) {
                        if packet.header.oper.get() == 1 && packet.header.dst_ip.equals(IP_ADDR) {
                            let mut response = ARP {
                                header: packet.header,
                                data: packet.data.clone(),
                            };
                            response.header.oper.set(2);
                            response.header.dst_mac = packet.header.src_mac;
                            response.header.dst_ip = packet.header.src_ip;
                            response.header.src_mac = unsafe { MAC_ADDR };
                            response.header.src_ip = IP_ADDR;

                            link.write(response.to_bytes().as_slice());
                        }
                    }
                }
                None => unsafe { context_switch(false) },
            }
        }
    }
}