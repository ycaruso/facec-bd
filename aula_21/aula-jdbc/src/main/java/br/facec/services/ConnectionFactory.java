package br.facec.services;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionFactory {

	enum Schema {
		
		DATA_BASE_EMPRESA("jdbc:postgresql://localhost:5432/empresa","postgres","postgres");
//		DATA_BASE2("jdbc:mysql:ip:porta/schema1","root","");
		
		private String url;
		private String usuario;
		private String senha;
	
		Schema(String url,String usuario, String senha){
			this.url = url;
			this.usuario = usuario;
			this.senha = senha;
			
		}
		
		public String getSenha() {
			return senha;
		}
		
		public String getUrl() {
			return url;
		}
		
		public String getUsuario() {
			return usuario;
		}
	} // end enum

	public static java.sql.Connection getConnection(Schema schema) {  
		Connection connection = null;  
		
		try {  
			/* Obtém o driver de conexão com o banco de dados */  
//			Class.forName("com.mysql.jdbc.Driver");
			Class.forName("org.postgresql.Driver");
			
			/* Configura os parâmetros da conexão */  
			String url = schema.getUrl();  
			String username = schema.getUsuario();   
			String password = schema.getSenha();  
			
			/* Tenta se conectar */  
			connection = DriverManager.getConnection(url, username, password);  
			System.out.println("Conexão efetuada com sucesso.");
			/* Caso a conexão ocorra com sucesso, a conexão é retornada */  
			return connection;  
			
		} catch (ClassNotFoundException e) {              
			System.out.println("O driver expecificado nao foi encontrado.");  
			return null;  
			
		} catch (SQLException e) {  
			System.out.println("Nao foi possivel conectar ao banco de dados.");  
			return null;  
		}  
	} // end método getConnection
} // end class connectionFactory