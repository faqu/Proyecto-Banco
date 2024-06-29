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

const CrudLogin = () => {
    const navigate = useNavigate();
    const [data, setData] = useState([]);
    const [roles, setRoles] = useState([]); // New state for roles data
    const [newRoleName, setNewRoleName] = useState('');
    const [NewContrasena, setNewContrasena] = useState('');
    const [selectedIdLogin, setSelectedLoginId] = useState(null);
    const [NewRoleId, setNewRoleId] = useState(null);


    useEffect(() => {
        fetchData();
        fetchRoles();
    }, []);

    const fetchData = async () => {
        try {
            const response = await fetch('http://127.0.0.1:8000/api/api/Login/');
            const jsonData = await response.json();
            setData(jsonData);
            console.log('First item details:', jsonData);
        } catch (error) {
            console.error('Error fetching data:', error);
        }
    };
    const fetchRoles = async () => {
        try {
            const response = await fetch('http://127.0.0.1:8000/api/api/Roles/');
            const rolesData = await response.json();
            setRoles(rolesData);
        } catch (error) {
            console.error('Error fetching roles:', error);
        }
    };
    const handleDelete = async (id) => {
        try {
            await fetch(`http://127.0.0.1:8000/api/api/Login/${id}/`, {
                method: 'DELETE',
            });
            fetchData();
        } catch (error) {
            console.error('Error deleting data:', error);
        }
    };

    const handlePut = (id, correo, contrasena, fk_roles) => {
        setNewRoleName(correo);
        setNewContrasena(contrasena);
        setNewRoleId(fk_roles);
        setSelectedLoginId(id);
    };

    const handleCreateOrUpdate = async () => {
        try {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            if (!newRoleName || !emailRegex.test(newRoleName) || !NewContrasena || !/\d/.test(NewContrasena) || NewContrasena.length <= 8) {
                alert('Por favor, ingrese un correo electrónico y una contraseña válidos (más de 8 caracteres, incluyendo un número).');
                return;
            }
            console.log('Data to be sent:', { correo: newRoleName, contrasena: NewContrasena, fk_roles: NewRoleId });

            if (selectedIdLogin) {
                // If there is a selectedRoleId, perform update (Actualizar)
                await fetch(`http://127.0.0.1:8000/api/api/Login/${selectedIdLogin}/`, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({ correo: newRoleName, contrasena: NewContrasena, fk_roles: NewRoleId }),
                });
            } else {
                // Otherwise, perform create (Crear)
                await fetch('http://127.0.0.1:8000/api/api/Login/', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({ correo: newRoleName, contrasena: NewContrasena, fk_roles: NewRoleId }),
                });
            }

            fetchData();
            setNewRoleName('');
            setNewContrasena('');
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
                        placeholder="Escriba el correo electronico"
                        value={newRoleName}
                        onChange={(e) => setNewRoleName(e.target.value)}
                    />
                    <Form.Control
                        type="text"
                        placeholder="Escriba la contrasena"
                        value={NewContrasena}
                        onChange={(e) => setNewContrasena(e.target.value)}
                    />
                    {/* Select item list for roles */}
                    <Form.Select
                        aria-label="Seleccionar rol"
                        value={NewRoleId}  // Change this to the correct state variable
                        onChange={(e) => setNewRoleId(e.target.value)}
                    >
                        <option key="" value="">
                            Seleccionar rol
                        </option>
                        {roles.map((role) => (
                            <option key={role.idroles} value={role.idroles}>
                                {role.nombre_rol}
                            </option>
                        ))}
                    </Form.Select>
                    <ButtonStyled onClick={handleCreateOrUpdate}>
                        {selectedIdLogin ? 'Actualizar' : 'Crear'}
                    </ButtonStyled>
                </ActionButtons>
                <br></br>
                <br></br>
                <List>
                    <ListItem>
                        <strong>Correo</strong>
                        <strong>Contrasena</strong>
                        <strong>Fecha Registro</strong>
                        <strong>Acciones</strong>
                    </ListItem>
                </List>
                <List>
                    {data.map((item) => (
                        <ListItem key={item.idlogin}>
                            <span style={{}}>{item.correo}</span>
                            <span style={{ overflow: 'hidden', textOverflow: 'ellipsis', maxWidth: '200px', marginRight: '20px' }}>{item.contrasena}</span>
                            <span style={{}}>{item.fecha_registro}</span>
                            <ActionButtons>
                                <ActionButton onClick={() => handlePut(item.idlogin, item.correo, item.contrasena, item.fk_roles.id)}>
                                    Actualizar
                                </ActionButton>
                                <ActionButton onClick={() => handleDelete(item.idlogin)}>
                                    Borrar
                                </ActionButton>
                            </ActionButtons>
                        </ListItem>
                    ))}
                </List>

            </Wrapper>

        </>
    );
};

export default CrudLogin;
