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


const CrudTransferencias = () => {
    const navigate = useNavigate();
    const [data, setData] = useState([]);
    const [filter, setFilter] = useState('');
    const [originalData, setOriginalData] = useState([]);
    useEffect(() => {
        fetchData();
    }, []);

    const fetchData = async () => {
        try {
            const response = await fetch('http://localhost:32768/api/Transacciones');
            const jsonData = await response.json();
            setData(jsonData);
            setOriginalData(jsonData);
            console.log('First item details:', jsonData);
        } catch (error) {
            console.error('Error fetching data:', error);
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

    const handleCrudTipoDeTansaccion = () => {
        // Add logic for logout, and then redirect to the login page
        // For now, let's assume the logic for logout is just navigating to the login page
        navigate('/CrudTipoDeTransaccion'); // Replace '/login' with the actual path of your login page
    };

    const handleTipoCuenta = () => {
        navigate('/CrudTipoCuenta');
    };
    const handleEstadoCuenta = () => {
        navigate('/CrudEstadoCuenta');
    };
    const handleMovimientosBancarios = () => {
        navigate('/MovimientosBancarios');
    };
    const handleFilterChange = (e) => {
        setFilter(e.target.value);
    };
    const handleCuetaBancaria = () => {
        navigate('/CrudCuentaBancaria')
    }
    const handleFilterClick = () => {
        const newFilteredData = originalData.filter(item =>
            item.tipoNavigation.toLowerCase().includes(filter.toLowerCase())
        );
        setData(newFilteredData);
        console.log('Filtro:', newFilteredData);
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
                                <NavDropdown.Item onClick={handleCuetaBancaria}>Cuentas Bancarias</NavDropdown.Item>
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
                <Form>
                    <Form.Group className="mb-3" controlId="formBasicEmail">
                        <Form.Control
                            type="text"
                            placeholder="Filtre por Tipo de transaccion"
                            value={filter}
                            onChange={handleFilterChange}
                        />
                    </Form.Group>
                    <ButtonStyled onClick={handleFilterClick}>
                        Apply Filter
                    </ButtonStyled>
                </Form>
                <br></br>
                <ActionButtons>
                    <ButtonStyled onClick={handleMovimientosBancarios} >
                        Realizar Movimientos bancarios
                    </ButtonStyled>
                </ActionButtons>
                <br></br>
                <br></br>
                <List>
                    <ListItem>
                        <strong>Cuenta Origen</strong>
                        <strong style={{ marginLeft: '10px', marginRight: '25px' }}>Tipo de transaccion</strong>
                        <strong>Monto</strong>
                        <strong style={{ marginLeft: '25px', marginRight: '10px' }}>Cuenta Origen</strong>
                        <strong>Fecha de transaccion</strong>
                    </ListItem>
                </List>
                <List>
                    {data.map((item) => (
                        <ListItem key={item.id}>
                            <span>{item.cuentaOrigen}</span>
                            <span>{item.tipoNavigation}</span>
                            <span>{item.monto}</span>
                            <span>{item.cuentaDestino}</span>
                            <span>{item.fechaTransaccion}</span>
                        </ListItem>
                    ))}
                </List>
            </Wrapper>

        </>
    );
};

export default CrudTransferencias;
