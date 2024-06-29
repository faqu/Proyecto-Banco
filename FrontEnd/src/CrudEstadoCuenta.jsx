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

const ActionButton = styled(ButtonStyled)`
    margin-bottom: 0;
    float: none;
`;

const CrudEstadoCuenta = () => {
    const navigate = useNavigate();
    const [data, setData] = useState([]);
    const [newRoleName, setNewRoleName] = useState('');
    const [selectedRoleId, setSelectedRoleId] = useState(null);

    useEffect(() => {
        fetchData();
    }, []);

    const fetchData = async () => {
        try {
            const response = await fetch('http://localhost:32768/api/EstadoCuenta');
            const jsonData = await response.json();
            setData(jsonData);
            console.log('First item details:', jsonData);
        } catch (error) {
            console.error('Error fetching data:', error);
        }
    };

    const handlePut = (id, nombre_rol) => {
        setNewRoleName(nombre_rol);
        setSelectedRoleId(id);
    };

    const handleCreateOrUpdate = async () => {
        try {
            if (!newRoleName) {
                console.log('Please enter a role name.');
                return;
            }

            if (selectedRoleId) {
                // If there is a selectedRoleId, perform update (Actualizar)
                await fetch(`http://localhost:32768/api/EstadoCuenta/${selectedRoleId}`, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({ tipoEstadoCuenta: newRoleName }),
                });
            } else {
                // Otherwise, perform create (Crear)
                await fetch('http://localhost:32768/api/EstadoCuenta/Insertar', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({ tipoEstadoCuenta: newRoleName }),
                });
            }

            fetchData();
            setNewRoleName('');
            setSelectedRoleId(null);
        } catch (error) {
            console.error('Error creating/updating role:', error);
        }
    };

    const handleLogout = () => {
        navigate('/');
    };
    const handleLogin = () => {
        navigate('/CrudLogin');
    };
    const handleRoles = () => {
        navigate('/CrudRoles');
    };
    const handleTipoTransaccion = () => {
        navigate('/CrudTipoDeTransaccion');
    };
    const handleTransferencias = () => {
        navigate('/CrudTransferencias');
    };
    const handleEstadoCuenta = () => {
        navigate('/CrudEstadoCuenta');
    };
    const handleCuetaBancaria = () => {
        navigate('/CrudCuentaBancaria')
    }
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
                                <NavDropdown.Item onClick={handleLogin}>
                                    Usuarios
                                </NavDropdown.Item>
                                <NavDropdown.Item onClick={handleRoles}>
                                    Roles
                                </NavDropdown.Item>
                            </NavDropdown>
                            <NavDropdown title="Api SqlServer y C#.netCore" id="navbarScrollingDropdown">
                                <NavDropdown.Item onClick={handleCuetaBancaria} >Cuentas Bancarias</NavDropdown.Item>
                                <NavDropdown.Divider />
                                <NavDropdown.Item onClick={handleEstadoCuenta} >
                                    Estado Cuentas Bancarias
                                </NavDropdown.Item>
                                <NavDropdown.Divider />
                                <NavDropdown.Item onClick={handleTipoTransaccion}>
                                    Tipo De Transacciones Bancarias
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
                        placeholder="Escriba el nombre del Tipo Cuenta"
                        value={newRoleName}
                        onChange={(e) => setNewRoleName(e.target.value)}
                    />
                    <ButtonStyled onClick={handleCreateOrUpdate}>
                        {selectedRoleId ? 'Actualizar' : 'Crear'}
                    </ButtonStyled>
                </ActionButtons>
                <br></br>
                <br></br>
                <List>
                    <ListItem>
                        <strong>Tipo Cuenta</strong>
                        <strong style={{ marginRight: '30px' }}>Acciones</strong>
                    </ListItem>
                </List>
                <List>
                    {data.map((item) => (
                        <ListItem key={item.idEstadoCuenta}>
                            {item.tipoEstadoCuenta}
                            <ActionButtons>
                                <ActionButton onClick={() => handlePut(item.idEstadoCuenta)}>
                                    Actulizar
                                </ActionButton>
                            </ActionButtons>
                        </ListItem>
                    ))}
                </List>
            </Wrapper>
        </>
    );
};

export default CrudEstadoCuenta;
