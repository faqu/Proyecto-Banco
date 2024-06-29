using System;
using System.Collections.Generic;

namespace ApiSqlServer.Models;

public partial class AuditLog
{
    public int LogId { get; set; }

    public string? OperationType { get; set; }

    public int? Id { get; set; }

    public string? NumeroCuenta { get; set; }

    public string? TipoCuenta { get; set; }

    public decimal? Saldo { get; set; }

    public string? PropietarioNombre { get; set; }

    public DateOnly? FechaApertura { get; set; }

    public string? Estadocuenta { get; set; }

    public DateTime? ChangeDateTime { get; set; }

    public virtual CuentaBancaria? IdNavigation { get; set; }
}
