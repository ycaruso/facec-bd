package br.facec.bo;

import java.sql.Date;

public class Funcionario {
	
	private String cpf;
	private String prim_nome;
	private String nome_meio;
	private String ultimo_nome;
	private Date dt_nascimento;
	private String endereco;
	private String sexo;
	private Double salario;
	private String cpf_supervisor;
	private int num_depto;
	private int ativo;
	public String getCpf() {
		return cpf;
	}
	public void setCpf(String cpf) {
		this.cpf = cpf;
	}
	public String getPrim_nome() {
		return prim_nome;
	}
	public void setPrim_nome(String prim_nome) {
		this.prim_nome = prim_nome;
	}
	public String getNome_meio() {
		return nome_meio;
	}
	public void setNome_meio(String nome_meio) {
		this.nome_meio = nome_meio;
	}
	public String getUltimo_nome() {
		return ultimo_nome;
	}
	public void setUltimo_nome(String ultimo_nome) {
		this.ultimo_nome = ultimo_nome;
	}
	public Date getDt_nascimento() {
		return dt_nascimento;
	}
	public void setDt_nascimento(Date dt_nascimento) {
		this.dt_nascimento = dt_nascimento;
	}
	public String getEndereco() {
		return endereco;
	}
	public void setEndereco(String endereco) {
		this.endereco = endereco;
	}
	public String getSexo() {
		return sexo;
	}
	public void setSexo(String sexo) {
		this.sexo = sexo;
	}
	public Double getSalario() {
		return salario;
	}
	public void setSalario(Double salario) {
		this.salario = salario;
	}
	public String getCpf_supervisor() {
		return cpf_supervisor;
	}
	public void setCpf_supervisor(String cpf_supervisor) {
		this.cpf_supervisor = cpf_supervisor;
	}
	public int getNum_depto() {
		return num_depto;
	}
	public void setNum_depto(int num_depto) {
		this.num_depto = num_depto;
	}
	public int getAtivo() {
		return ativo;
	}
	public void setAtivo(int ativo) {
		this.ativo = ativo;
	}
	
	@Override
	public String toString() {
		return this.cpf + " | " +
				this.prim_nome + " " +
				this.nome_meio + " " +
				this.ultimo_nome + " | " +
				this.sexo + " | " +
				this.dt_nascimento + " | " +
				this.endereco + " | " +
				String.format("%,.2f", this.salario) + " | " +
				this.ativo + " | " +
				this.cpf_supervisor + "\n";
	}
	
}
