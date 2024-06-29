import { useState, useEffect } from 'react';
import styled from 'styled-components';
import Button from 'react-bootstrap/Button';
import Container from 'react-bootstrap/Container';
import Form from 'react-bootstrap/Form';
import Nav from 'react-bootstrap/Nav';
import Navbar from 'react-bootstrap/Navbar';
import NavDropdown from 'react-bootstrap/NavDropdown';
import { useNavigate } from 'react-router-dom';
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

const ButtonStyled = styled(Button)`
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

const List = styled.ul`
    list-style: none;
    padding: 0;
`;

const ListItem = styled.li`
    margin-bottom: 10px;
    display: flex;
    justify-content: space-between;
    align-items: center;

    @media (max-width: 600px) {
        flex-direction: column;
        align-items: flex-start;

        & > button {
            margin-top: 10px;
        }
    }
`;

const ActionButtons = styled.div`
    display: flex;
    gap: 10px;
`;

const CrudCuentaBancaria = () => {
    const navigate = useNavigate();
    const [data, setData] = useState([]);
    const [TipoCuenta, setTipoCuenta] = useState([]); // New state for roles data
    const [newSaldo, setSaldo] = useState('');
    const [NewContrasena, setNewContrasena] = useState('');
    const [tipo_cuenta, settipo_cuenta] = useState(null);
    const [NewNombrePropietario, setNombrePropietario] = useState(null);


    useEffect(() => {
        fetchData();
        fetchTipoCuenta();
    }, []);

    const fetchData = async () => {
        try {
            const response = await fetch('http://localhost:32768/api/CuentaBancarias');
            const jsonData = await response.json();
            setData(jsonData);
            console.log('First item details:', jsonData);
        } catch (error) {
            console.error('Error fetching data:', error);
        }
    };
    const fetchTipoCuenta = async () => {
        try {
            const response = await fetch('http://localhost:32768/api/TipoCuentas');
            const TipoCuentaData = await response.json();
            setTipoCuenta(TipoCuentaData);
        } catch (error) {
            console.error('Error fetching roles:', error);
        }
    };
    

    const handleCreateOrUpdate = async () => {
        try {
            const response = await fetch(`http://localhost:32768/api/CuentaBancarias/CrearCuenta/${NewContrasena}/${tipo_cuenta}/${newSaldo}/${NewNombrePropietario}/${1}`, {
                method: 'POST'
            });

            if (response.ok) {
                fetchData();
                setSaldo('');
                setNewContrasena('');
                setNombrePropietario('');
                settipo_cuenta('');
            } else {
                console.error('Error creating/updating role:', response.status, response.statusText);
            }
        } catch (error) {
            console.error('Error creating/updating role:', error);
        }
    };

    const handleLogout = () => {
        // Add logic for logout, and then redirect to the login page
        // For now, let's assume the logic for logout is just navigating to the login page
        navigate('/'); // Replace '/login' with the actual path of your login page
    };
    const handleRoles = () => {
        // Add logic for logout, and then redirect to the login page
        // For now, let's assume the logic for logout is just navigating to the login page
        navigate('/CrudRoles'); // Replace '/login' with the actual path of your login page
    };
    const handleEstadoCuenta = () => {
        navigate('/CrudEstadoCuenta');
    };
    const handleCrudTipoDeTansaccion = () => {
        // Add logic for logout, and then redirect to the login page
        // For now, let's assume the logic for logout is just navigating to the login page
        navigate('/CrudTipoDeTransaccion'); // Replace '/login' with the actual path of your login page
    };
    const handleTipoCuenta = () => {
        navigate('/CrudTipoCuenta');
    };
    const handleTransferencias = () => {
        navigate('/CrudTransferencias');
    };
    return (
        <>
            <Navbar expand="lg" className="bg-body-tertiary">
                <Container fluid>
                    <Navbar.Brand href="#">Proyecto</Navbar.Brand>
                    <Navbar.Toggle aria-controls="navbarScroll" />
                    <Navbar.Collapse id="navbarScroll">
                        <Nav
                            className="me-auto my-2 my-lg-0"
                            style={{ maxHeight: '100px' }}
                            navbarScroll
                        >
                            <NavDropdown title="Api Oracle y Phython" id="navbarScrollingDropdown">
                                <NavDropdown.Item onClick={handleRoles}>
                                    Roles
                                </NavDropdown.Item>
                            </NavDropdown>
                            <NavDropdown title="Api SqlServer y C#.netCore" id="navbarScrollingDropdown">
                                <NavDropdown.Item onClick={handleEstadoCuenta} >
                                    Estado Cuentas Bancarias
                                </NavDropdown.Item>
                                <NavDropdown.Divider />
                                <NavDropdown.Item onClick={handleTipoCuenta}>
                                    Tipo De Cuentas Bancarias
                                </NavDropdown.Item>
                                <NavDropdown.Divider />
                                <NavDropdown.Item onClick={handleCrudTipoDeTansaccion}>
                                    Tipo De Transaccion Bancaria
                                </NavDropdown.Item>
                                <NavDropdown.Divider />
                                <NavDropdown.Item onClick={handleTransferencias}>
                                    Transacciones Bancarias
                                </NavDropdown.Item>
                            </NavDropdown>
                        </Nav>
                        <Form className="d-flex">
                            <Button variant="outline-success" onClick={handleLogout}>Cerrar Seccion</Button>
                        </Form>
                    </Navbar.Collapse>
                </Container>
            </Navbar>

            <Wrapper>
                <Title>Operaciones CRUD</Title>
                <br></br>
                <ActionButtons>
                    {/* Text field for new role name */}
                    <Form.Control
                        type="text"
                        placeholder="Digite el Saldo"
                        value={newSaldo}
                        onChange={(e) => setSaldo(e.target.value)}
                    />
                    <Form.Control
                        type="text"
                        placeholder="Escriba el Numero Cuenta"
                        value={NewContrasena}
                        onChange={(e) => setNewContrasena(e.target.value)}
                    />
                    <Form.Control
                        type="text"
                        placeholder="Escriba el Nombre Propietario"
                        value={NewNombrePropietario}
                        onChange={(e) => setNombrePropietario(e.target.value)}
                    />
                    {/* Select item list for roles */}
                    <Form.Select
                        aria-label="Seleccionar Tipo Cuenta"
                        value={tipo_cuenta}  // Change this to the correct state variable
                        onChange={(e) => settipo_cuenta(e.target.value)}
                    >
                        <option key="" value="">
                            Seleccionar rol
                        </option>
                        {TipoCuenta.map((tipocuenta) => (
                            <option key={tipocuenta.id} value={tipocuenta.id}>
                                {tipocuenta.nombre}
                            </option>
                        ))}
                    </Form.Select>
                    <ButtonStyled onClick={handleCreateOrUpdate}>
                        Crear Cuenta
                    </ButtonStyled>
                </ActionButtons>
                <br></br>
                <br></br>
                <List>
                    <ListItem>
                        <strong>Cuenta</strong>
                        <strong>Saldo</strong>
                        <strong>Nombre Propietario</strong>
                        <strong>Fecha Apertura</strong>
                    </ListItem>
                </List>
                <List>
                    {data.map((item) => (
                        <ListItem key={item.id}>
                            <span style={{}}>{item.numeroCuenta}</span>
                            <span style={{ overflow: 'hidden', textOverflow: 'ellipsis', maxWidth: '200px', marginRight: '20px' }}>{item.saldo}</span>
                            <span style={{}}>{item.propietarioNombre}</span>
                            <span style={{}}>{item.fechaApertura}</span>
                        </ListItem>
                    ))}
                </List>

            </Wrapper>

        </>
    );
};

export default CrudCuentaBancaria;
