using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace ApiSqlServer.Models;

public partial class Transaccione
{
    public int Id { get; set; }

    public int Tipo { get; set; }

    public decimal Monto { get; set; }
    [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
    public DateOnly FechaTransaccion { get; set; }

    public int CuentaOrigenId { get; set; }

    public int? CuentaDestinoId { get; set; }

    public virtual CuentaBancaria? CuentaDestino { get; set; }

    public virtual CuentaBancaria CuentaOrigen { get; set; } = null!;

    public virtual TipoDeTransaccion TipoNavigation { get; set; } = null!;
}
