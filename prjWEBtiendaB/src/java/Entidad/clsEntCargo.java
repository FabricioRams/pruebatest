package Entidad;

/**
 *
 * @author HP
 */
public class clsEntCargo {
    private int idcargo;
    private String nombre;

    // Constructor vacío necesario para instanciación sin argumentos
    public clsEntCargo() {
    }

    public clsEntCargo(int idcargo, String nombre) {
        this.idcargo = idcargo;
        this.nombre = nombre;
    }

    public int getIdcargo() {
        return idcargo;
    }

    public void setIdcargo(int idcargo) {
        this.idcargo = idcargo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }}