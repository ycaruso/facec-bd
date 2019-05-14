package br.facec.services;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import br.facec.bo.Funcionario;
import br.facec.services.ConnectionFactory;
import br.facec.services.ConnectionFactory.Schema;

public class ServicesBDEmpresa {
	
	private Connection con;
	private Statement stm;
		
	public ServicesBDEmpresa(Connection con) throws SQLException {
		this.con = con;
		this.stm = con.createStatement();
		System.out.println("Serviços conectado ao BD Empresa.");
	}
	
	public Connection getCon() {
		return con;
	}

	public void setCon(Connection con) {
		this.con = con;
	}
	
	public void close() throws SQLException {
		this.con.close();
	}
	
	/**
	 * 
	 * @throws SQLException
	 */
	public void createTableCategoriaProjeto() throws SQLException {
		String tableSql = "create table if not exists "
			+ "categoria_projeto(num_cat_proj serial primary key,"
			+ "descricao varchar(100) not null);";
		this.stm.execute(tableSql);
		System.out.println("Tabela categoria_projeto criada com sucesso.");
	}
	
	/**
     * Insert de dados
	 * @throws SQLException 
     */
	public void insertCategoriaProjeto() throws SQLException {

	  String insertSQL = "insert into categoria_projeto(descricao)" + 
	  		"values ('Projeto de Software')," + 
	  		"	('Projeto construção')," + 
	  		"	('Projeto de automação')," + 
	  		"	('Projetos internos');";
	  
	  int linhasAfetadas = this.stm.executeUpdate(insertSQL);
      System.out.println("Foi inserido " + linhasAfetadas 
    		  + " linhas na tabela categoria_projeto.");
	}
	
    /**
     * PreparedStatements, Ex: Update Table
     * passando parâmetros;
     * @throws SQLException 
     */
	public void atualizaDescCategoriaProjeto(String desc, int numCategoria)
			throws SQLException {

	      String sqlUpdate = "update categoria_projeto "
	      		+ "set descricao=? "
	      		+ "where num_cat_proj=?";	      
	      PreparedStatement pstmt = this.con.prepareStatement(sqlUpdate);
	      pstmt.setString(1, desc);
	      pstmt.setInt(2, numCategoria);
	      
	      int linhasAfetadas = pstmt.executeUpdate();
	      System.out.println("Foi atualizado " + linhasAfetadas 
	    		  + " linhas na tabela categoria_projeto.");

	      pstmt.close();
	}

	
	public String getTamanhoDepartamento(int num_depto) throws SQLException {
		/**
	       * CallableStatement, Ex: call procedure/function
	       */
	      String functionCall = "{?= call tam_departamento(?)}";
	      CallableStatement cstmt = con.prepareCall(functionCall);
	      cstmt.setInt(2, num_depto);
	      cstmt.registerOutParameter(1, Types.VARCHAR);
	      cstmt.execute();
	      System.out.println("Tamanho do departamento " + num_depto 
	    		  + " é " + cstmt.getString(1));
	      return cstmt.getString(1);
	}
	
	/**
     * Retorna todos os funcionarios do banco
     * Lendo Resultados com objeto ResultSet
	 * @throws SQLException 
     */
	public List<Funcionario> getTodosFuncionarios() throws SQLException {

	      ResultSet res = stm.executeQuery("Select * from funcionario");

	      /**
	       * Criar a Lista de Objetos Funcionario
	       */
	      List<Funcionario> listFunc = new ArrayList<Funcionario>();
	      
	      while (res.next()) {
	    	  Funcionario fun = new Funcionario();
	    	  fun.setCpf(res.getString("cpf"));
	    	  fun.setPrim_nome(res.getString("primeiro_nome"));
	    	  fun.setNome_meio(res.getString("nome_meio"));
	    	  fun.setUltimo_nome(res.getString("ultimo_nome"));
	    	  fun.setDt_nascimento(res.getDate("dt_nascimento"));
	    	  fun.setSalario(res.getDouble("salario"));
	    	  fun.setSexo(res.getString("sexo"));
	    	  fun.setEndereco(res.getString("endereco"));
	    	  fun.setAtivo(res.getInt("ativo"));
	    	  fun.setCpf_supervisor(res.getString("cpf_supervisor"));
	    	  // Adiciona na Lista
	    	  listFunc.add(fun);
	      }

	      System.out.println("Foi executado consulta listaTodosFuncionarios");
	      return listFunc;

	}

	/**
	 * Atualiza novo salario
	 * utilizando atualização pelo ResultSet com cursor
	 * @param cpf
	 * @param novoSalario
	 * @throws SQLException 
	 */
	public void atualizaNovoSalarioFuncionario(String cpf,
			double novoSalario) throws SQLException {

		Statement stm2 = con.createStatement(
				ResultSet.TYPE_SCROLL_INSENSITIVE, 
				ResultSet.CONCUR_UPDATABLE);

	      String selectSql = "select *" + 
	      		" FROM public.funcionario" +
	    		" WHERE cpf='" + cpf + "'";
	      	      
	      ResultSet res2 = stm2.executeQuery(selectSql);
	      res2.next();
	      res2.updateDouble("salario", novoSalario);
	      res2.updateRow();
	}
	
	
	public void listGetTables() throws SQLException {
		DatabaseMetaData dbmd = con.getMetaData();
		
		String[] types = {"TABLE"};
		
		ResultSet tablesResultSet = dbmd.getTables("empresa", "", "%", types);
		while (tablesResultSet.next()) {
		    System.out.println(tablesResultSet.getString("TABLE_NAME"));
		}
	}
	
	/**
	 * Query que retorna os funcionarios
	 * 
	 * @param args
	 * @throws SQLException 
	 */
	public void imprimeAtributosResultSet() throws SQLException {
		ResultSet res = stm.executeQuery("Select * from funcionario");

		ResultSetMetaData rsmd = res.getMetaData();
		int qtdeCols = rsmd.getColumnCount();
		
		for (int i=1; i <= qtdeCols; i++) {
			System.out.println(i + " " + rsmd.getColumnName(i));
		}
	}
	
	public void atualizaDeptoSalarioFuncionario(int numDepto, 
			double salario, String cpf) throws SQLException {
		
		String updateDepto = "update funcionario" + 
				" set num_depto=?" + 
				" where cpf=? ";
		PreparedStatement pstmt = con.prepareStatement(updateDepto);
		pstmt.setInt(1, numDepto);
		pstmt.setString(2, cpf);
		 
		String updateSalario = "update funcionario" + 
				" set salario= ? " + 
				" where cpf=? ";
		PreparedStatement pstmt2 = con.prepareStatement(updateSalario);
		pstmt2.setDouble(1, salario);
		pstmt2.setString(2, cpf);
		 
		boolean autoCommit = con.getAutoCommit();
		try {
		    con.setAutoCommit(false);
		    pstmt.executeUpdate();
		    pstmt2.executeUpdate();
		    con.commit();
		} catch (SQLException exc) {
		    con.rollback();
		} finally {
		    con.setAutoCommit(autoCommit);
		}
	}
	
	public void getLastFuncUpdated() throws SQLException {
		Statement stm2 = con.createStatement(
				ResultSet.TYPE_SCROLL_INSENSITIVE, 
				ResultSet.CONCUR_UPDATABLE);

	      String selectSql = "select *" + 
	      		" FROM public.funcionario";
	      	      
	      ResultSet res2 = stm2.executeQuery(selectSql);
	      res2.last();
	      System.out.println(res2.getString(1));

	      stm2.close();
	}
	
	public void getFirstFuncUpdated() throws SQLException {
		Statement stm2 = con.createStatement(
				ResultSet.TYPE_SCROLL_INSENSITIVE, 
				ResultSet.CONCUR_UPDATABLE);

	      String selectSql = "select *" + 
	      		" FROM public.funcionario";
	      	      
	      ResultSet res2 = stm2.executeQuery(selectSql);
	      res2.first();
	      System.out.println(res2.getString(1));

	      stm2.close();
	}
	
	public static void main(String[] args) {
	
	    try{

	    	ServicesBDEmpresa services = new ServicesBDEmpresa(
	    			ConnectionFactory.getConnection(Schema.DATA_BASE_EMPRESA));

	    	services.createTableCategoriaProjeto();
	    	services.insertCategoriaProjeto();
	    	services.atualizaDescCategoriaProjeto("Projeto de Engenharia", 1);
	    	services.getTamanhoDepartamento(3);
	    	
	    	List<Funcionario> listaFuncionarios = 
	    			services.getTodosFuncionarios();
	    	System.out.println(listaFuncionarios.toString());
	    	
	    	services.atualizaNovoSalarioFuncionario("09421362926", 77775.0 );
	    	
	    	services.listGetTables();
	    	
	    	services.imprimeAtributosResultSet();
	    	
	    	services.atualizaDeptoSalarioFuncionario(1, 10000, "90139762981");
	      
	    	services.getLastFuncUpdated();
	    	services.getFirstFuncUpdated();
	    
	    	services.close();
	    }
	    catch(Exception e){
	      e.printStackTrace();
	    }
	  }

	}
