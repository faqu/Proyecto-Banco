using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace ApiSqlServer.Models;

public partial class ApiCuentasContablesContext : DbContext
{
    public ApiCuentasContablesContext()
    {
    }

    public ApiCuentasContablesContext(DbContextOptions<ApiCuentasContablesContext> options)
        : base(options)
    {
    }

    public virtual DbSet<AuditLog> AuditLogs { get; set; }

    public virtual DbSet<CuentaBancaria> CuentaBancaria { get; set; }

    public virtual DbSet<EstadoCuenta> EstadoCuenta { get; set; }

    public virtual DbSet<TipoCuenta> TipoCuenta { get; set; }

    public virtual DbSet<TipoDeTransaccion> TipoDeTransaccions { get; set; }

    public virtual DbSet<Transaccione> Transacciones { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    { }
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<AuditLog>(entity =>
        {
            entity.HasKey(e => e.LogId).HasName("PK__AuditLog__5E5499A80E5A0BCF");

            entity.ToTable("AuditLog");

            entity.Property(e => e.LogId).HasColumnName("LogID");
            entity.Property(e => e.ChangeDateTime).HasColumnType("datetime");
            entity.Property(e => e.Estadocuenta)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("estadocuenta");
            entity.Property(e => e.FechaApertura).HasColumnName("fecha_apertura");
            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.NumeroCuenta)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("numero_cuenta");
            entity.Property(e => e.OperationType)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.PropietarioNombre)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("propietario_nombre");
            entity.Property(e => e.Saldo)
                .HasColumnType("decimal(18, 2)")
                .HasColumnName("saldo");
            entity.Property(e => e.TipoCuenta)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("tipo_cuenta");

            entity.HasOne(d => d.IdNavigation).WithMany(p => p.AuditLogs)
                .HasForeignKey(d => d.Id)
                .HasConstraintName("FK_AuditLog_CuentaBancaria");
        });

        modelBuilder.Entity<CuentaBancaria>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__CuentaBa__3213E83F2D6D334E");

            entity.ToTable(tb => tb.HasTrigger("CuentaBancaria_Audit"));

            entity.HasIndex(e => e.NumeroCuenta, "UQ__CuentaBa__C6B74B88C4D1EB66").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Estadocuenta).HasColumnName("estadocuenta");
            entity.Property(e => e.FechaApertura).HasColumnName("fecha_apertura");
            entity.Property(e => e.NumeroCuenta)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("numero_cuenta");
            entity.Property(e => e.PropietarioNombre)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("propietario_nombre");
            entity.Property(e => e.Saldo)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("saldo");
            entity.Property(e => e.TipoCuenta).HasColumnName("tipo_cuenta");

            entity.HasOne(d => d.EstadocuentaNavigation).WithMany(p => p.CuentaBancaria)
                .HasForeignKey(d => d.Estadocuenta)
                .HasConstraintName("FK_CuentaBancaria_EstadoCuenta");

            entity.HasOne(d => d.TipoCuentaNavigation).WithMany(p => p.CuentaBancaria)
                .HasForeignKey(d => d.TipoCuenta)
                .HasConstraintName("FK__CuentaBan__tipo___3F466844");
        });

        modelBuilder.Entity<EstadoCuenta>(entity =>
        {
            entity.HasKey(e => e.IdEstadoCuenta).HasName("PK__EstadoCu__79FBA946A70D0045");

            entity.Property(e => e.TipoEstadoCuenta)
                .HasMaxLength(75)
                .HasColumnName("Tipo_EstadoCuenta");
        });

        modelBuilder.Entity<TipoCuenta>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Tipo_Cue__3213E83F30F23C54");

            entity.ToTable("Tipo_Cuenta");

            entity.HasIndex(e => e.Nombre, "UQ__Tipo_Cue__72AFBCC65F4ECF8D").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Nombre)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("nombre");
        });

        modelBuilder.Entity<TipoDeTransaccion>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Tipo_De___3213E83F7E67C0E0");

            entity.ToTable("Tipo_De_Transaccion");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.TipoTrasaccion)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("tipo_trasaccion");
        });

        modelBuilder.Entity<Transaccione>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Transacc__3213E83FDD4AD30E");

            entity.ToTable(tb => tb.HasTrigger("Despues_insertar_transaccion"));

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.CuentaDestinoId).HasColumnName("cuenta_destino_id");
            entity.Property(e => e.CuentaOrigenId).HasColumnName("cuenta_origen_id");
            entity.Property(e => e.FechaTransaccion).HasColumnName("fecha_transaccion");
            entity.Property(e => e.Monto)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("monto");
            entity.Property(e => e.Tipo).HasColumnName("tipo");

            entity.HasOne(d => d.CuentaDestino).WithMany(p => p.TransaccioneCuentaDestinos)
                .HasForeignKey(d => d.CuentaDestinoId)
                .HasConstraintName("FK__Transacci__cuent__412EB0B6");

            entity.HasOne(d => d.CuentaOrigen).WithMany(p => p.TransaccioneCuentaOrigens)
                .HasForeignKey(d => d.CuentaOrigenId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Transacci__cuent__403A8C7D");

            entity.HasOne(d => d.TipoNavigation).WithMany(p => p.Transacciones)
                .HasForeignKey(d => d.Tipo)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Transaccio__tipo__4222D4EF");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
