using System;
using System.Collections.Generic;

namespace ApiSqlServer.Models;

public partial class CuentaBancaria
{
    public int Id { get; set; }

    public string NumeroCuenta { get; set; } = null!;

    public int? TipoCuenta { get; set; }

    public decimal Saldo { get; set; }

    public string PropietarioNombre { get; set; } = null!;

    public DateOnly FechaApertura { get; set; }

    public int? Estadocuenta { get; set; }

    public virtual ICollection<AuditLog> AuditLogs { get; set; } = new List<AuditLog>();

    public virtual EstadoCuenta? EstadocuentaNavigation { get; set; }

    public virtual TipoCuenta? TipoCuentaNavigation { get; set; }

    public virtual ICollection<Transaccione> TransaccioneCuentaDestinos { get; set; } = new List<Transaccione>();

    public virtual ICollection<Transaccione> TransaccioneCuentaOrigens { get; set; } = new List<Transaccione>();
}
