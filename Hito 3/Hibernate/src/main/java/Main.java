import ormRPGgame.Controller;
import ormRPGgame.model.Mago;
import ormRPGgame.model.Daga;

public class Main {

    public static void main (String [] args) {
        try {
            Controller controlador= new Controller();
            //@TODO añada las llamadas a las funciones de la clase Controller.java necesarias
            //para la creación de la daga y el mago.
            Daga daga1=new Daga(1L,"de Madera");
            Mago mago1=new Mago("Raul",10,100,5);
            if(daga1!=null && mago1!=null)
                System.out.println("Se ha creado el mago "+mago1.getId_m()+" de nivel" +mago1.getNivel() + "con la daga "+daga1.getnombre());
        } catch(Exception e) {
            System.err.println("Se ha producido un error en la conexión con la base de datos");
            e.printStackTrace();
        }
    }
}
