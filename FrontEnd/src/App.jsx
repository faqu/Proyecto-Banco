import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import Login from './Login';
import Crud from './CrudRoles';
import Crud1 from './CrudLogin';
import Crud2 from './CrudTipoDeTransaccion';
import Crud3 from './CrudTipoCuenta';
import Crud4 from './CrudEstadoCuenta';
import Crud5 from './CrudTransferencias';
import Crud6 from './CrudCuentaBancaria';
import Mov from './MovimientosBancarios';
import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap/dist/js/bootstrap.bundle.min";

const App = () => {
    return (
        <Router>
            <Routes>
                <Route path="/" element={<Login />} />
                <Route path="/CrudRoles" element={<Crud />} />
                <Route path="/CrudLogin" element={<Crud1 />} />
                <Route path="/CrudTipoDeTransaccion" element={<Crud2 />} />
                <Route path="/CrudTipoCuenta" element={<Crud3 />} />
                <Route path="/CrudEstadoCuenta" element={<Crud4 />} />
                <Route path="/CrudTransferencias" element={<Crud5 />} />
                <Route path="/CrudCuentaBancaria" element={<Crud6 />} />
                <Route path="/MovimientosBancarios" element={<Mov />} />
            </Routes>
        </Router>
    );
};

export default App;

