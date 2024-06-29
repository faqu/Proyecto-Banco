import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import styled from 'styled-components';
const Wrapper = styled.div`
  width: fit-content;
  margin: 20px auto;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
`;

const Title = styled.h2`
  text-align: center;
  color: #333;
`;

const ButtonStyled = styled.button`
  margin-bottom: 10px;
  padding: 8px;
  background-color: #007bff;
  color: #fff;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  float: right;

  &:hover {
    background-color: #0056b3;
  }
`;



const MovimientosBancarios = () => {
    const navigate = useNavigate();
    const [opcion1, setOpcion1] = useState('');
    const [numero, setNumero] = useState('');
    const [opcion2, setOpcion2] = useState('');
    const [opcion3, setOpcion3] = useState('');
    const [cuentasActivas, setCuentasActivas] = useState([]);
    const [tiposDeTransacciones, setTiposDeTransacciones] = useState([]);
    const [cuentaSeleccionada, setCuentaSeleccionada] = useState(null);
    const [cuentaSeleccionadaOpcion3, setCuentaSeleccionadaOpcion3] = useState(null);
    useEffect(() => {
        // Llamada a la API para obtener las cuentas activas
        const obtenerCuentasActivas = async () => {
            try {
                const response = await fetch('http://localhost:32768/api/CuentaBancarias/CuentasActivas');
                if (response.ok) {
                    const data = await response.json();
                    setCuentasActivas(data);
                } else {
                    console.error('Error al obtener cuentas activas');
                }
            } catch (error) {
                console.error('Error de red:', error);
            }
        };

        // Llamada a la API para obtener los tipos de transacciones
        const obtenerTiposDeTransacciones = async () => {
            try {
                const response = await fetch('http://localhost:32768/api/TipoDeTransaccions');
                if (response.ok) {
                    const data = await response.json();
                    setTiposDeTransacciones(data);
                } else {
                    console.error('Error al obtener tipos de transacciones');
                }
            } catch (error) {
                console.error('Error de red:', error);
            }
        };

        obtenerCuentasActivas();
        obtenerTiposDeTransacciones();
    }, []);
    useEffect(() => {
        // Llamada a la API para obtener los detalles de la cuenta seleccionada
        const obtenerDetallesCuenta = async () => {
            if (opcion1) {
                try {
                    const response = await fetch(`http://localhost:32768/api/CuentaBancarias/${opcion1}`);
                    if (response.ok) {
                        const data = await response.json();
                        setCuentaSeleccionada(data);
                    } else {
                        console.error('Error al obtener detalles de la cuenta');
                    }
                } catch (error) {
                    console.error('Error de red:', error);
                }
            }
        };

        obtenerDetallesCuenta();
    }, [opcion1]);
    useEffect(() => {
        // Llamada a la API para obtener los detalles de la cuenta seleccionada en opcion3
        const obtenerDetallesCuentaOpcion3 = async () => {
            if (opcion3) {
                try {
                    const response = await fetch(`http://localhost:32768/api/CuentaBancarias/${opcion3}`);
                    if (response.ok) {
                        const data = await response.json();
                        setCuentaSeleccionadaOpcion3(data);
                    } else {
                        console.error('Error al obtener detalles de la cuenta (opcion3)');
                    }
                } catch (error) {
                    console.error('Error de red:', error);
                }
            }
        };

        obtenerDetallesCuentaOpcion3();
    }, [opcion3]);
    const handleOpcion1Change = (event) => {
        setOpcion1(event.target.value);
    };

    const handleNumeroChange = (event) => {
        // Validar que solo sean números
        const valor = event.target.value.replace(/[^0-9]/g, '');
        setNumero(valor);
    };

    const handleOpcion2Change = (event) => {
        const valor = event.target.value;
        setOpcion2(valor);
    };

    const handleOpcion3Change = (event) => {
        setOpcion3(event.target.value);
    };
    const realizarTransferencia = async () => {
        if (opcion2 == 1 || opcion2 == 2 && opcion1 && numero) {
            try {
                const response = await fetch(
                    `http://localhost:32768/api/Transacciones/RetiroYDeposito/${opcion2}/${numero}/${opcion1}`,
                    { method: 'POST' }
                );

                if (response.ok) {
                    navigate('/CrudTransferencias');
                    // Realizar acciones adicionales después de la transferencia
                    console.log('Transferencia exitosa');
                } else {
                    console.error('Error al realizar la transferencia');
                }
            } catch (error) {
                console.error('Error de red:', error);
            }
        }
        if (opcion2 == 3 && opcion1 && opcion3 && numero) {
            try {
                const response = await fetch(
                    `http://localhost:32768/api/Transacciones/Transferencia/${opcion2}/${numero}/${opcion1}/${opcion3}`,
                    { method: 'POST' }
                );

                if (response.ok) {
                    navigate('/CrudTransferencias');
                    // Realizar acciones adicionales después de la transferencia
                    console.log('Transferencia exitosa');
                } else {
                    console.error('Error al realizar la transferencia');
                }
            } catch (error) {
                console.error('Error de red:', error);
            }
        }
    };
    // Filtrar las cuentas para la opción 3 excluyendo la cuenta seleccionada en la opción 1
    const cuentasParaOpcion3 = cuentasActivas.filter(
        (cuenta) => cuenta.id !== opcion1
    );

    return (
        <Wrapper>
            <meta charset="UTF-8"/>
            <Title>Movimientos Bancarios</Title>
            <div>
                <label>
                    Cuenta Origen:
                    <select value={opcion1} onChange={handleOpcion1Change}>
                        <option value="">Selecciona una Cuenta</option>
                        {cuentasActivas.map((cuenta) => (
                            <option key={cuenta.id} value={cuenta.id}>
                                {cuenta.numeroCuenta} - Saldo: {cuenta.saldo}
                            </option>
                        ))}
                    </select>
                </label>

                <label>
                    Movimietnos:
                    <select value={opcion2} onChange={handleOpcion2Change}>
                        <option value="">Selecciona una Movimiento Bancario</option>
                        {tiposDeTransacciones.map((tipo) => (
                            <option key={tipo.id} value={tipo.id}>
                                {tipo.tipoTrasaccion}
                            </option>
                        ))}
                    </select>
                </label>

                <label>
                    Monto:
                    <input type="text" value={numero} onChange={handleNumeroChange} />
                </label>

                {opcion2 == 3 && (
                    <label>
                        Cuenta Destiono 3:
                        <select value={opcion3} onChange={handleOpcion3Change}>
                            <option value="">Selecciona una cuenta</option>
                            {cuentasParaOpcion3.map((cuenta) => (
                                <option key={cuenta.id} value={cuenta.id}>
                                    {cuenta.numeroCuenta} - Saldo: {cuenta.propietarioNombre}
                                </option>
                            ))}
                        </select>
                    </label>
                )}
                <ButtonStyled onClick={realizarTransferencia}>Realizar Transferencia</ButtonStyled>
                {cuentaSeleccionada && (
                    <p>
                        Detalles de la cuenta Origen:
                        <br />
                        Numero de cuenta: {cuentaSeleccionada.numeroCuenta}
                        <br />
                        Saldo: {cuentaSeleccionada.saldo}
                        <br />
                        A nombre de:{cuentaSeleccionada.propietarioNombre}
                        {/* Agrega más detalles según la estructura de tu objeto de cuenta */}
                    </p>
                )}
                {cuentaSeleccionadaOpcion3 && (
                    <p>
                        Detalles de la cuenta Destino:
                        <br />
                        Numero de cuenta: {cuentaSeleccionadaOpcion3.numeroCuenta}
                        <br />
                        A nombre de:{cuentaSeleccionadaOpcion3.propietarioNombre}
                        {/* Agrega más detalles según la estructura de tu objeto de cuenta */}
                    </p>
                )}
            </div>
        </Wrapper>
    );
};

export default MovimientosBancarios;
