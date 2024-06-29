using System;
using System.Collections.Generic;

namespace ApiSqlServer.Models;

public partial class EstadoCuenta
{
    public int IdEstadoCuenta { get; set; }

    public string TipoEstadoCuenta { get; set; } = null!;

    public virtual ICollection<CuentaBancaria> CuentaBancaria { get; set; } = new List<CuentaBancaria>();
}
