import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.Enumeration;

// Fonction pour obtenir l'adresse IP locale
String getLocalIP() {
	try {
		// Parcourir les interfaces réseau
		Enumeration<NetworkInterface> interfaces = NetworkInterface.getNetworkInterfaces();
		while(interfaces.hasMoreElements()) {
			NetworkInterface iface = interfaces.nextElement();
			
			// Ignorer les interfaces inactives ou loopback (localhost)
			if (iface.isLoopback() || !iface.isUp()) continue;
			
			// Parcourir les adresses assignées à cette interface
			Enumeration<InetAddress> addresses = iface.getInetAddresses();
			while(addresses.hasMoreElements()) {
				InetAddress addr = addresses.nextElement();
				if (addr.isSiteLocalAddress()) {
					return addr.getHostAddress(); // Retourner l'adresse IP locale
				}
			}
		}
	} catch(Exception e) {
		println("Error fetching local IP: " + e.getMessage());
	}
	return "Unknown";
}