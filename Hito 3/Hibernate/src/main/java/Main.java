import ormRPGgame.Controller;
import ormRPGgame.model.Mago;
import ormRPGgame.model.Daga;

public class Main {

    public static void main (String [] args) {
        try {
            Controller controlador= new Controller();
            //@TODO añada las llamadas a las funciones de la clase Controller.java necesarias
            //para la creación de la daga y el mago.
            Mago mago = controlador.createMago("Tom Marvolo Riddle",100,20,5);
            Daga daga = controlador.createDagaMago(1L,"madera",mago);
        } catch(Exception e) {
            System.err.println("Se ha producido un error en la conexión con la base de datos");
            e.printStackTrace();
        }
    }
}
