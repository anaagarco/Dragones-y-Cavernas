import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import game.model.Dragon;

public class Main {
    // @TODO: Sustituya xxxx por los parámetros de su conexión

    private static final String DB_SERVER = "127.0.0.1";

    private static final int DB_PORT = 3306;

    private static final String DB_NAME = "DragonesyCavernas";

    private static final String DB_USER = "root";

    private static final String DB_PASS = "";

    private static Connection conn;


    public static void main(String[] args) throws Exception {

        Class.forName("com.mysql.cj.jdbc.Driver");

        String url = "jdbc:mysql://" + DB_SERVER + ":" + DB_PORT + "/" + DB_NAME;
        conn = DriverManager.getConnection(url, DB_USER, DB_PASS);

        // @TODO pruebe sus funciones

        nuevo_dragon("Viseryon");

        List<Dragon> listaDragones = squad_derrota_dragones(1L);

        for (Dragon dragon : listaDragones) System.out.println(dragon.getName());

        conn.close();
    }


    // @TODO resuelva las siguientes funciones...
    //  Necesitamos dragón
    public static void nuevo_dragon(String nombre) throws SQLException {
        // @TODO: complete este método para que cree un nuevo dragón en la base de datos

        Dragon dragon = new Dragon(nombre, 998, "Dehiss");
        try {
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO dragon (nombre_d, vida, nombre_d_desbloqueado) VALUES (?, ?, ?)");

            stmt.setString(1, dragon.getName());
            stmt.setInt(2, dragon.getLife());
            stmt.setString(3, dragon.getDragon_unlock());

            stmt.executeUpdate();

            System.out.printf("El nuevo dragon con nombre %s fue insertado correctamente.%n", nombre);

            stmt.close();
        } catch (Exception e) {
            System.out.println("Se produjo un error al insertar el dragon.");
            //throw new SQLException();
        }
    }

    // Necesitamos escuadron, escuadron_vence_dragon
    public static List<Dragon> squad_derrota_dragones(Long id_squad) throws SQLException {
        // @TODO: complete este método para que devuelva una lista de los dragones derrotados por el squad
        // Tenga en cuenta que la consulta a la base de datos le devolverá un ResultSet sobre el que deberá
        // ir iterando y creando un objeto dragon para cada uno de los dragones, y añadirlos a la lista

        List<Dragon> lista = new ArrayList<>();
        Statement stmt;
        ResultSet rs;

        try {
            String sql = "SELECT nombre_d FROM escuadron_vence_dragon WHERE id_e = " + id_squad;
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                lista.add(new Dragon(rs.getString("nombre_d")));
            }

            stmt.close();
        } catch (Exception e) {
            System.out.println("Se produjo un error al consultar los dragones derrotados.");
            //throw new SQLException();
        }
        return lista;
    }

    /*// Necesitamos hacha, forja
    public static List<Hacha> mostrar_hachas(String nombre_forja) {
        // @TODO: complete este método para que muestre por pantalla las hachas que pueden forjarse en "nombre_forja"
        // Tenga en cuenta que la consulta a la base de datos le devolverá un ResultSet sobre el que deberá
        // ir iterando y creando un objeto con cada hacha disponible en esa forja, y añadirlos a la lista
        return null;
    }*/

    // Necesitamos espada, guerrero
    public static String espada_porta_guerrero(String nombre_guerrero) {
        // @TODO: complete este método para que devuelva el nombre de la espada que porta el guerrero "nombre_guerrero"
        return "espadón";
    }

}
